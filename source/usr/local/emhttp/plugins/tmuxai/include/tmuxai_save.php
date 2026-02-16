<?php
/* Copyright zeddius1983 (TmuxAI plugin for Unraid)
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License 2
 * as published by the Free Software Foundation.
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 */
$return = [];

if(isset($_POST['config_content'])) {
    try {
        $config_file = '/mnt/user/appdata/tmuxai/config/config.yaml';
        
        // Security check - ensure we're only writing to our plugin directory
        // Use realpath to prevent path traversal attacks
        $allowed_dir = '/mnt/user/appdata/tmuxai/';
        $real_config_dir = dirname($config_file);
        
        // Ensure directory exists for realpath to work
        if (!is_dir($real_config_dir)) {
            mkdir($real_config_dir, 0755, true);
        }
        
        $real_config_file = realpath($real_config_dir) . '/' . basename($config_file);
        
        // Verify the resolved path is within our allowed directory
        if(!str_starts_with($real_config_file, $allowed_dir)) {
            $return["error"]["response"] = "File location is not allowed.";
            die(json_encode($return));
        }
        
        // Get config content from POST
        $config_content = str_replace("\r", '', $_POST['config_content']);
        
        // Save the configuration
        if(file_put_contents($real_config_file, $config_content) !== false) {
            $return["success"]["response"] = "Configuration saved successfully.";
        } else {
            $return["error"]["response"] = "Failed to save configuration file.";
        }
    }
    catch (\Throwable $t) {
        error_log("TmuxAI save error: " . $t->getMessage());
        $return["error"]["response"] = "An error occurred while saving the configuration.";
    }
    echo json_encode($return);
} else {
    $return["error"]["response"] = "No configuration data provided.";
    echo json_encode($return);
}
?>
