!macro customHeader
    RequestExecutionLevel highest
!macroend

!define __REGISTRY_KEY DemoKey

!macro customInstall
; ExecWait '"$INSTDIR\${PRODUCT_NAME}.exe"'
SetRegView 64
WriteRegStr HKCR "${__REGISTRY_KEY}" "" "URL:${PRODUCT_NAME}"
WriteRegStr HKCR "${__REGISTRY_KEY}" "URL Protocol" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell" "" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell\open" "" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell\open\command" "" '"$INSTDIR\${PRODUCT_NAME}.exe" "%1"'
SetRegView 32
WriteRegStr HKCR "${__REGISTRY_KEY}" "" "URL:${PRODUCT_NAME}"
WriteRegStr HKCR "${__REGISTRY_KEY}" "URL Protocol" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell" "" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell\open" "" ""
WriteRegStr HKCR "${__REGISTRY_KEY}\shell\open\command" "" '"$INSTDIR\${PRODUCT_NAME}.exe" "%1"'
!macroend


!macro customInit
    ; SHUT DOWN APP IF CURRENTLY RUNNING
    ${GetProcessInfo} 0 $0 $1 $2 $3 $4
    ${if} $3 != "${APP_EXECUTABLE_FILENAME}"
        ${nsProcess::FindProcess} "${APP_EXECUTABLE_FILENAME}" $R0
        ${If} $R0 == 0
            ;MessageBox MB_OK "App currently running - going to shutdown to install new version"
            ${nsProcess::CloseProcess} "${APP_EXECUTABLE_FILENAME}" $R0
            Sleep 5000
            ${nsProcess::KillProcess} "${APP_EXECUTABLE_FILENAME}" $R0
            Sleep 3000
        ${EndIf}
        ${nsProcess::Unload}
    ${endIf}
!macroend

!macro customUnInstall
; ${nsProcess::KillProcess} "${APP_EXE}" $R4
; ExecWait '"$INSTDIR\${PRODUCT_NAME}.exe"'
DeleteRegKey HKCR "${__REGISTRY_KEY}"
!macroend
