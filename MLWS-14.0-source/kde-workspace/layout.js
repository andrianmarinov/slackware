var panel = new Panel
if (panelIds.length == 1) {
    // we are the only panel, so set the location for the user
    panel.location = 'bottom'
}

panel.height = screenGeometry(panel.screen).height > 1024 ? 70 : 50
panel.addWidget("launcher")
var widget = panel.addWidget("icon")
widget.writeConfig("Url", "file:///usr/share/applications/kde4/dolphin.desktop")
var widget = panel.addWidget("icon")
widget.writeConfig("Url", "file:///usr/share/applications/mozilla-firefox.desktop")
var widget = panel.addWidget("icon")
widget.writeConfig("Url", "file:///usr/share/applications/mozilla-thunderbird.desktop")
var widget = panel.addWidget("icon")
widget.writeConfig("Url", "file:///opt/openoffice4/share/xdg/startcenter.desktop")
tasks = panel.addWidget("tasks")
panel.addWidget("systemtray")
panel.addWidget("digital-clock")
panel.addWidget("lockout")

tasks.currentConfigGroup = new Array("Launchers")

