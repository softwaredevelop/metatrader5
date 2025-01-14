<chart>
id=133323330323437240
symbol=EURUSD
description=Euro vs US Dollar
period_type=0
period_size=15
digits=5
tick_size=0.000000
position_time=1736498700
scale_fix=0
scale_fixed_min=1.017400
scale_fixed_max=1.031900
scale_fix11=0
scale_bar=0
scale_bar_val=1.000000
scale=4
mode=0
fore=0
grid=0
volume=0
scroll=1
shift=1
shift_size=9.174312
fixed_pos=0.000000
ticker=1
ohlc=1
one_click=0
one_click_btn=1
bidline=1
askline=1
lastline=0
days=0
descriptions=0
tradelines=1
tradehistory=0
window_left=52
window_top=52
window_right=851
window_bottom=474
window_type=3
floating=0
floating_left=0
floating_top=0
floating_right=0
floating_bottom=0
floating_type=1
floating_toolbar=1
floating_tbstate=
background_color=16777215
foreground_color=0
barup_color=0
bardown_color=0
bullcandle_color=16777215
bearcandle_color=0
chartline_color=0
volumes_color=32768
grid_color=12632256
bidline_color=12632256
askline_color=17919
lastline_color=12632256
stops_color=17919
windows_total=5

<window>
height=100.000000
objects=0

<indicator>
name=Main
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Trade\Heiken_Ashi.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=Heiken Ashi Open;Heiken Ashi High;Heiken Ashi Low;Heiken Ashi Close
draw=17
style=0
width=1
color=15570276,1993170
</graph>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Trade\VIDYA_14.ex5
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=VIDYA(14,14)
draw=1
style=0
width=1
color=32768
</graph>
<inputs>
InpPeriodCMO=14
InpPeriodEMA=14
InpShift=0
</inputs>
</indicator>

<indicator>
name=Custom Indicator
path=Indicators\Trade\ALMA_14.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=MA
draw=1
style=0
width=1
color=0
</graph>
<inputs>
_type=0
_length=14
_offset=0.85
_sigma=6
</inputs>
</indicator>

<indicator>
name=Bollinger Bands
path=
apply=1
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=131
style=0
width=1
color=11119017
</graph>

<graph>
name=
draw=131
style=0
width=1
color=11119017
</graph>

<graph>
name=
draw=131
style=0
width=1
color=11119017
</graph>
period=20
deviation=2.000000
</indicator>
</window>

<window>
height=50.000000
objects=0

<indicator>
name=Custom Indicator
path=Indicators\Trade\ADXW.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=ADX Wilder(14)
draw=1
style=0
width=1
color=16748574
</graph>

<graph>
name=+DI
draw=1
style=0
width=1
color=2330219
</graph>

<graph>
name=-DI
draw=1
style=0
width=1
color=4678655
</graph>

<level>
level=20.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=25.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=40.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=50.000000
style=2
color=12632256
width=1
descr=
</level>
<inputs>
InpPeriodADXW=14
</inputs>
</indicator>
</window>

<window>
height=50.000000
objects=0

<indicator>
name=Custom Indicator
path=Indicators\Trade\RSIMA.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=RSI
draw=1
style=0
width=1
color=32768
</graph>

<graph>
name=RSIMA
draw=1
style=0
width=1
color=16748574
</graph>

<level>
level=30.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=50.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=70.000000
style=2
color=12632256
width=1
descr=
</level>
<inputs>
InpPeriodRSI=14
InpAppliedPrice=1
InpPeriodMA=14
InpMethod=1
</inputs>
</indicator>
</window>

<window>
height=50.000000
objects=0

<indicator>
name=Custom Indicator
path=Indicators\Trade\FisherTransform.ex5
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=0
scale_fix_min_val=0.000000
scale_fix_max=0
scale_fix_max_val=0.000000
expertmode=4
fixed_height=-1

<graph>
name=Fisher
draw=1
style=0
width=1
color=255
</graph>

<graph>
name=Trigger
draw=1
style=0
width=1
color=16711680
</graph>

<level>
level=1.500000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=0.750000
style=2
color=36095
width=1
descr=
</level>

<level>
level=0.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=-0.750000
style=2
color=36095
width=1
descr=
</level>

<level>
level=-1.500000
style=2
color=12632256
width=1
descr=
</level>
<inputs>
Length=9
Shift=0
</inputs>
</indicator>
</window>

<window>
height=50.000000
objects=0

<indicator>
name=Williams' Percent Range
path=
apply=0
show_data=1
scale_inherit=0
scale_line=0
scale_line_percent=50
scale_line_value=0.000000
scale_fix_min=1
scale_fix_min_val=-100.000000
scale_fix_max=1
scale_fix_max_val=0.000000
expertmode=0
fixed_height=-1

<graph>
name=
draw=1
style=0
width=1
color=14772545
</graph>

<level>
level=-80.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=-20.000000
style=2
color=12632256
width=1
descr=
</level>

<level>
level=-50.000000
style=2
color=12632256
width=1
descr=
</level>
period=14
</indicator>
</window>
</chart>
