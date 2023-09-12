#!/bin/bash

STATUS=$(acpi -b | awk '{print $3}')

if [[ "$STATUS" == "Not" ]]; then
    echo "$(acpi -b | awk '{print $5}')"
else
    echo "$(acpi -b | awk '{print $4}' | rev | cut -c 3- | rev)"
fi
