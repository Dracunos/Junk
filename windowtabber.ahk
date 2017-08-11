MakeGui()
{
    Gui, +AlwaysOnTop +ToolWindow -Border
    Gui, Color, bfbfbf
    Gui, Add, Button, x0 y-3 w14 h25 gReset, R
    Gui, Add, Button, x13 y-3 h25 gAddTab, Add Tab
    Gui, Add, Button, x65 y-3 h25 gRmTab, RmTab

    Gui, Show, x-1680 y0 w1674 h20, No Activation
    Return
}

MakeGui()

tab_list := Object()
title_list := Object()

Return

AddTab:
    Send !{ESC}
    WinGet, lastwindow, , A
    WinGetTitle, wintitle, A
    StringLeft, wintitle, wintitle, 12
    tab_list.Push(lastwindow)
    title_list.Push(wintitle)
    Gosub AddAllTabs
Return

AddAllTabs:
    Gui, Destroy
    MakeGui()
    buttonNextPos := 117
    Loop % tab_list.Length()
    {
        maketabkey(A_Index)
        tablistlen := tab_list.Length()
        currentTab := tab_list[A_Index]
        currentTabTitle := title_list[A_Index]
        Gui, Add, Button, v%A_Index% x%buttonNextPos% y-3 w80 h25 hwndButton%currentTab%, %currentTabTitle%
        gFunc:=Func("TabCallback").Bind(currentTab)
        GuiControl, +g, % Button%currentTab%, % gFunc
        buttonNextPos += 79
    }
Return
    
RmTab:
    tab_list.Pop()
    title_list.Pop()
    Gosub AddAllTabs
Return

TabCallback(id)
{
    IfWinNotExist, ahk_id %id%
        Return
    WinActivate, ahk_id %id%
    WinMove, A, , -1680, 24, 1680, 1030
    Return
}

maketabkey(num)
{
    global
    if (num == 10)
        num := 0
    if (num > 10)
        Return
    Hotkey, ^!%num%, HotkeyCallbackFocus
    Hotkey, !+%num%, HotkeyCallback
    Return
}

HotkeyCallbackFocus:
    key := 0
    Loop, 10
    {
        GetKeyState, keystate, %key%
        if keystate = D
            break
        key += 1
    }
    if (key == 0)
        key := 10
    TabCallback(tab_list[key])
    for index, val in tab_list
    {
        if (win_id == val)
            Return
    }
Return

HotkeyCallback:
    WinGet, win_id, ID, A
    key := 0
    Loop, 10
    {
        GetKeyState, keystate, %key%
        if keystate = D
            break
        key += 1
    }
    if (key == 0)
        key := 10
    TabCallback(tab_list[key])
    for index, val in tab_list
    {
        if (win_id == val)
            Return
    }
    WinActivate, ahk_id %win_id%
Return


Reset:
    Reload
