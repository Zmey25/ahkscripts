/*
WinSet_Click_Through = Делает окно сквозь кликабельным

I = ID окна чтобы сделать клики сквозь

T = Transparency к окну

если окно не существует оно возвращается в Return 0
*/

AnimPicFile := A_ScriptDir "\bind.gif"
WinSet_Click_Through(I, T="210") {
    IfWinExist, % "ahk_id " I
    {
        If (T == "Off")
        {
            WinSet, AlwaysOnTop, Off, % "ahk_id " I
            WinSet, Transparent, Off, % "ahk_id " I
            WinSet, ExStyle, -0x20, % "ahk_id " I
        }
        Else
        {
            WinSet, AlwaysOnTop, On, % "ahk_id " I
            If(T < 0 || T > 254 || T == "On")
                T := 254
            WinSet, Transparent, % T, % "ahk_id " I
            WinSet, ExStyle, +0x20, % "ahk_id " I
        }
    }
    Else
        Return 0
}
w_sc := A_ScreenWidth + 10
h_sc := A_ScreenHeight + 10

AGif := AddAnimatedGIF(AnimPicFile,-10,-10,w_sc,h_sc)

Gui, 1: -Caption +AlwaysOnTop +E0x08000000 +Lastfound 
Gui, 1: Margin, 0, 0
ID := WinExist()
Gui, 1: Add, Picture,, %AGif%
Gui, 1: Add, text, x100 y100 1111111
Gui, 1: Show, maximize, Bind1
Gui, 1: Show
WinSet_Click_Through(ID)
GuiControl,, Bind1, Un-Clickable 


AddAnimatedGIF(imagefullpath , x="", y="", w="", h="", guiname = "1")
{
	global AG1,AG2,AG3,AG4,AG5,AG6,AG7,AG8,AG9,AG10
	static AGcount:=0, pic
	AGcount++
	html := "<html><body style='background-color: transparent' style='overflow:hidden' leftmargin='0' topmargin='0'><img src='" imagefullpath "' width=" w " height=" h " border=0 padding=0></body></html>"
	Gui, AnimGifxx:Add, Picture, vpic, %imagefullpath%
	GuiControlGet, pic, AnimGifxx:Pos
	Gui, AnimGifxx:Destroy
	Gui, %guiname%:Add, ActiveX, % (x = "" ? " " : " x" x ) . (y = "" ? " " : " y" y ) . (w = "" ? " w" picW : " w" w ) . (h = "" ? " h" picH : " h" h ) " vAG" AGcount, Shell.Explorer
	AG%AGcount%.navigate("about:blank")
	AG%AGcount%.document.write(html)
	return "AG" AGcount
}
