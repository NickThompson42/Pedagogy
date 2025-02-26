from flask import Blueprint, request, render_template, redirect, url_for
from app.key_manager import (
    get_active_key, 
    get_developer_key, 
    add_user_key, 
    remove_user_key, 
    load_user_keys, 
    set_active_key
)

main_bp = Blueprint('main', __name__)

@main_bp.route("/api-key-config", methods=["GET", "POST"])
def api_key_config():
    # Load current state
    user_data = load_user_keys()
    dev_key = get_developer_key()
    active_key = get_active_key()
    saved_keys = user_data["saved_keys"]
    last_used_name = user_data["last_used_key_name"]

    if request.method == "POST":
        # If user selected developer key
        if "use_dev_key" in request.form:
            set_active_key(None)
            return redirect(url_for("main.api_key_config"))
        
        # If user is adding a new key
        new_name = request.form.get("new_key_name")
        new_value = request.form.get("new_key_value")
        persist = bool(request.form.get("persist"))
        if new_name and new_value:
            add_user_key(new_name, new_value, persist=persist)
            return redirect(url_for("main.api_key_config"))

        # If user selected an existing key to activate
        chosen_key = request.form.get("chosen_key_name")
        if chosen_key:
            set_active_key(chosen_key)
            return redirect(url_for("main.api_key_config"))

        # If user wants to remove a key
        key_to_remove = request.form.get("remove_key_name")
        if key_to_remove:
            remove_user_key(key_to_remove)
            return redirect(url_for("main.api_key_config"))

    return render_template(
        "api_key_config.html",
        dev_key=dev_key,
        active_key=active_key,
        saved_keys=saved_keys,
        last_used_name=last_used_name
    )
