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

function startsWith($string, $startString) {
    return substr($string, 0, strlen($startString)) === $startString;
}

if(isset($_POST['config_content'])) {
    try {
        $config_file = '/boot/config/plugins/tmuxai/config/config.yaml';
        
        // Security check - ensure we're only writing to our plugin directory
        if(!startsWith($config_file, "/boot/config/plugins/tmuxai/")) {
            $return = [];
            $return["error"]["response"] = "File location is not allowed.";
            die(json_encode($return));
        }
        
        // Get config content from POST
        $config_content = str_replace("\r", '', $_POST['config_content']);
        
        // Ensure directory exists
        $config_dir = dirname($config_file);
        if (!is_dir($config_dir)) {
            mkdir($config_dir, 0755, true);
        }
        
        // Save the configuration
        if(file_put_contents($config_file, $config_content) !== false) {
            $return["success"]["response"] = $config_file;
        } else {
            $return["error"]["response"] = "Failed to save configuration file.";
        }
    }
    catch (\Throwable $t) {
        error_log("TmuxAI save error: " . $t->getMessage());
        $return = [];
        $return["error"]["response"] = "An error occurred while saving the configuration.";
    }
    echo json_encode($return);
} else {
    $return["error"]["response"] = "No configuration data provided.";
    echo json_encode($return);
}
?>
