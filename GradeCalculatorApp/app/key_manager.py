import os
import json

# Where we store the developer key (not committed to source control).
DEV_KEY_PATH = os.path.join("local_keys", "dev_key.txt")

# Where we store user keys (JSON).
USER_KEYS_PATH = os.path.join("local_keys", "api_keys.json")

# In-memory storage for ephemeral keys (not persisted).
_ephemeral_keys = {}

def get_developer_key():
    """
    Returns the developer key from dev_key.txt if it exists,
    otherwise None.
    """
    if os.path.exists(DEV_KEY_PATH):
        with open(DEV_KEY_PATH, "r") as f:
            return f.read().strip()
    return None

def load_user_keys():
    """
    Loads user key data from api_keys.json.
    Returns a dict structure like:
    {
      "saved_keys": [
        {"name": "My Key", "api_key": "sk-..."},
        ...
      ],
      "last_used_key_name": "My Key"
    }
    If file doesn't exist, returns a default structure.
    """
    if not os.path.exists(USER_KEYS_PATH):
        return {"saved_keys": [], "last_used_key_name": None}
    
    with open(USER_KEYS_PATH, "r") as f:
        return json.load(f)

def save_user_keys(data):
    """
    Saves the given dict structure back to api_keys.json.
    Ensures local_keys folder exists first.
    """
    os.makedirs("local_keys", exist_ok=True)
    with open(USER_KEYS_PATH, "w") as f:
        json.dump(data, f, indent=2)

def get_active_key():
    """
    Returns the currently active API key.
    1) If the user has a 'last_used_key_name', returns that key.
    2) Otherwise, returns the developer key.
    """
    # First check ephemeral override
    data = load_user_keys()
    if data.get("last_used_key_name"):
        # find this in ephemeral or saved keys
        # check ephemeral memory
        last_key = data["last_used_key_name"]
        if last_key in _ephemeral_keys:
            return _ephemeral_keys[last_key]
        
        # otherwise check saved keys
        for item in data["saved_keys"]:
            if item["name"] == last_key:
                return item["api_key"]
    # fallback
    return get_developer_key()

def set_active_key(name):
    """
    Sets the 'last_used_key_name' to the given key name (which can be
    in ephemeral memory or saved keys). If name is None or empty,
    we revert to dev key.
    """
    data = load_user_keys()
    if not name:
        data["last_used_key_name"] = None
    else:
        # check ephemeral or saved
        ephemeral_exists = (name in _ephemeral_keys)
        saved_exists = any(k["name"] == name for k in data["saved_keys"])
        if ephemeral_exists or saved_exists:
            data["last_used_key_name"] = name
        else:
            # Key doesn't exist yet, do nothing or raise an error
            pass
    save_user_keys(data)

def add_user_key(name, api_key, persist=False):
    """
    Adds or updates a user key with 'name' and 'api_key'.
    If persist=True, writes to api_keys.json.
    If persist=False, stores in ephemeral memory only.
    Also sets this key as 'last_used_key_name'.
    """
    if not name or not api_key:
        return  # no-op or raise an exception

    data = load_user_keys()

    if persist:
        # Check if key name exists in saved_keys; update or add
        for item in data["saved_keys"]:
            if item["name"] == name:
                item["api_key"] = api_key
                break
        else:
            data["saved_keys"].append({"name": name, "api_key": api_key})
        
        data["last_used_key_name"] = name
        save_user_keys(data)
    else:
        # ephemeral
        _ephemeral_keys[name] = api_key
        # set last_used_key_name in the user keys structure
        data["last_used_key_name"] = name
        # We do NOT write ephemeral key to file
        save_user_keys(data)

def remove_user_key(name):
    """
    Removes a user key from persisted storage (if it exists).
    Also removes ephemeral key by that name, if present.
    If that was the active key, resets last_used_key_name to None.
    """
    data = load_user_keys()
    # Remove from saved_keys
    data["saved_keys"] = [k for k in data["saved_keys"] if k["name"] != name]
    
    # Remove ephemeral if it exists
    if name in _ephemeral_keys:
        del _ephemeral_keys[name]
    
    # Reset last_used_key_name if needed
    if data.get("last_used_key_name") == name:
        data["last_used_key_name"] = None
    
    save_user_keys(data)
