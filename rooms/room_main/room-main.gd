extends Control

@onready var cSig: Node = get_node( "cSig" )
@onready var nUI: Control = get_node( "UI" )
@onready var nUIMainMenu: Control = nUI.get_node( "UIMainMenu" )
@onready var nUISettings: Control = nUI.get_node( "UISettings" )
@onready var nGame: Node = get_node( "Game" )

var previous_menu: Control

func _ready() -> void:
	#	Enable if developing for mobile.
	#get_tree().set_auto_accept_quit( false )
	nUIMainMenu.visible = true
	#	New Game
	nUIMainMenu.menu_new_game.connect( Callable( cSig, "_on_menu_new_game" ) )
	#	Continue Game
	#	Settings
	nUIMainMenu.menu_settings.connect( Callable( cSig, "_on_menu_settings" ) )
	nUISettings.new_language.connect(
			Callable( cSig, "_on_new_language" ) )
	nUISettings.menu_settings_closed.connect(
			Callable( cSig, "_on_menu_settings_closed" ) )
	#	Quit
	nUIMainMenu.menu_quit.connect( Callable( cSig, "_on_menu_quit" ) )
	nUIMainMenu.menu_focus()
	#	Mainly have to do this just so that the language adjusts correctly.
	TranslationServer.set_locale(
			UserSettings.accessibility[ "current_language" ] )


func destroy() -> void:
	#	Should run all destroy functions that can be located in game.
	nUIMainMenu.menu_new_game.disconnect(
			Callable( cSig, "_on_menu_new_game" ) )
	nUISettings.new_language.disconnect(
			Callable( cSig, "_on_new_language" ) )
	nUISettings.menu_settings_closed.disconnect(
			Callable( cSig, "_on_menu_settings_closed" ) )
	nUIMainMenu.menu_settings.disconnect( 
			Callable( cSig, "_on_menu_settings" ) )
	nUIMainMenu.menu_quit.disconnect( Callable( cSig, "_on_menu_quit" ) )
	nUISettings.destroy()
	#	Any awaits go here.
	get_tree().quit( 0 )
