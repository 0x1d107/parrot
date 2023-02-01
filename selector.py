#!/bin/env python
import sys,os
import curses
selected = ""
if len(sys.argv) < 3:
    quit()
stdscr = curses.initscr()
curses.noecho()
curses.cbreak()
stdscr.keypad(True)
stdscr.clear()
lines =[]
selection = 0
cursor = 0
def scroll2sel(down = False):
    global cursor
    if selection - cursor >= stdscr.getmaxyx()[0]-1 or selection < cursor:
        cursor = selection 
        if down:
            cursor = max(0,cursor - stdscr.getmaxyx()[0] +2)
with open(sys.argv[1]) as f:
    lines = f.readlines()
while True:
    stdscr.clear()
    for i,line in enumerate(lines[cursor:cursor+stdscr.getmaxyx()[0]-1]):
        attr = 0
        if i+cursor == selection:
            attr = curses.A_BOLD
            stdscr.addstr(i,0,'>')
        stdscr.addstr(i,2,line.split('\t')[0][:stdscr.getmaxyx()[1]-2],attr)
    k = stdscr.getch()
    if k == ord('q'):
        break
    elif k == ord('j') or k == curses.KEY_DOWN:
        if not len(lines):
            continue
        stdscr.addstr(selection-cursor,0,' ')
        selection+=1
        selection%=len(lines)
        scroll2sel()
    elif k == ord('k') or k == curses.KEY_UP:
        if not len(lines):
            continue
        stdscr.addstr(selection-cursor,0,' ')
        selection-=1
        selection%=len(lines)
        scroll2sel(True)
    elif k == ord('\n'):
        if not len(lines):
            break
        selected = lines[selection]
        break
    elif k == curses.KEY_MOUSE:
        m_id,x,y,z,bstate = curses.getmouse()
        if bstate & curses.BUTTON1_CLICKED:
            selection = y+cursor
            selection %= len(lines)
            scroll2sel()

if selected:
    with open(sys.argv[2],'w') as f:
        print(selected,file=f)
curses.nocbreak()
curses.echo()
stdscr.keypad(False)
curses.endwin()
