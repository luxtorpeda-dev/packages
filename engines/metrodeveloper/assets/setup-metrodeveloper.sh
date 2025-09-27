#!/bin/bash
if [[ "$SteamAppId" == "43110" || "$SteamAppId" == "43160" ]]; then # 2033 OR Last Light
   ln -sf  "$PWD/MetroDeveloper/original-2033-LL/dinput8.dll" .
   ln -sf  "$PWD/MetroDeveloper/original-2033-LL/MetroDeveloper.asi" .
   ln -sf  "$PWD/MetroDeveloper/original-2033-LL/MetroDeveloper.ini" .
elif [[ "$SteamAppId" == "286690" || "$SteamAppId" == "287390" || "$SteamAppId" == "412020" ]]; then # 2033 Redux OR Last Light Redux OR Exodus
   ln -sf  "$PWD/MetroDeveloper/redux-arktika-exodus/dinput8.dll" .
   ln -sf  "$PWD/MetroDeveloper/redux-arktika-exodus/MetroDeveloper.asi" .
   ln -sf  "$PWD/MetroDeveloper/redux-arktika-exodus/MetroDeveloper.ini" .
else
  exit 1
fi