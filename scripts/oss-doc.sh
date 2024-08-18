#!/bin/bash
# This script is to update the placeholders in the repo with the project information.

# GitHub values
GITHUB_ORG="ContinuousEngineeringProject"
GITHUB_PROJECT_NAME="Continuous Engineering Factory GKE Module"
GITHUB_REPO="ce-oss-template"
GITHUB_BOT_NAME="@ceProject-bot"
GITHUB_ISSUE_REPO="issues"

# SonarCloud values
SONAR_PROJECT_KEY="ContinuousEngineeringProject_terraform-google-factory"
SONAR_ORGANIZATION="continuous-engineering-project"

# Slack values
SLACK_WORKSPACE="continuousengproject"

expandVarsStrict(){
  local line lineEscaped

  while IFS= read -r line || [[ -n $line ]]; do
    IFS= read -r -d '' lineEscaped < <(printf %s "$line" | tr '`([$' '\1\2\3\4')
    lineEscaped=${lineEscaped//$'\4'{/\${}
    lineEscaped=${lineEscaped//\"/\\\"}
    eval "printf '%s\n' \"$lineEscaped\"" | tr '\1\2\3\4' '`([$'
  done
}

# Root folder path
ROOT_FOLDER="../testfiles"

# Use find to get all files under the root folder and its subdirectories
find "$ROOT_FOLDER" -type f | while read -r FILE; do

    # Process each file
    eval "echo \"$(< "$FILE")\"" > "$FILE"
    expandVarsStrict < "$FILE"

done