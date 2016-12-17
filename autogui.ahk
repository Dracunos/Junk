CoordMode, Mouse, Screen

Gui, +AlwaysOnTop -SysMenu
Gui, Add, Text, x0, Mouse Pos(win+\):
Gui, Add, Text, x+0 vmpos w60, 
Gui, Add, Button, gsetup, Setup
Gui, Add, Button, gclickfirst, Time Charges
Gui, Add, Button, gclick, Complete
Gui, Add, Button, gExit, Close
vtestvar = "test"
Gui, Add, Button, Vtestvar gTest, Test
Gui, Show, NoActivate, Autoclicker

f(x)
{
    MsgBox %x%
}

Return

Test:
  GuiControlGet, x, , testvar
  f(x)
Return


#\::
    MouseGetPos, mx, my
    GuiControl, , mpos, %mx% %my%
Return

Setup:
  Click, 572, 992
  Click, 1182, 391
  Sleep, 500
  Click, 1275, 281
  MouseMove, 1158, 639
Return

ClickFirst:
  Click, Down, 1469, 558
  MouseMove, 1384, 560
  Click, Up
  Send, ^x
  Click, 388, 438
  Sleep, 500
  Click, Down
  MouseMove, 1469, 558
  Click, Up
  Click, 248, 435
  Sleep, 500
  Click, Down
  MouseMove, 1479, 519
  Sleep, 100
  Click, Up
  Click, 1457, 774
  MouseMove, 1182, 521
Return

Click:
  Click, 1379, 506
  Click, 1368, 586
  Click, 1354, 544
  Click, 1346, 580
  Click, 189, 406
  Sleep, 500
  Click, Down
  MouseMove, 1349, 661
  Click, Up
  MouseMove, 1204, 264
Return

Exit:
  ExitApp
Return