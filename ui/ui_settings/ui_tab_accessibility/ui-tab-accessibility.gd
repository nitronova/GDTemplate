extends VBoxContainer

@onready var nSignals: Node = get_node( "Signals" )
@onready var nOptionButtonLanguages: OptionButton = get_node(
		"HBCLanguages/OptionButtonLanguage" )
@onready var nHBCFonts: HBoxContainer = get_node( "HBCFonts" )
@onready var nButtonPrevFont: Button = nHBCFonts.get_node( "ButtonPrevFont" )
@onready var nLabelCurrentFont: Label = nHBCFonts.get_node( "LabelCurrentFont" )
@onready var nButtonNextFont: Button = nHBCFonts.get_node( "ButtonNextFont" )

var font_array: Array = []


func set_font( font_index: int ) -> void:
	#	Wrap index around array limits
	if( font_index < 0 ):
		font_index = max( 0, font_array.size() - 1 )
	elif( font_index >= font_array.size() ):
		font_index = 0
	GlobalUserSettings.set_current_font_index( font_index )
	nLabelCurrentFont.text = font_array[ font_index ]
	GlobalUserSettings.save_settings()
	GlobalTheme.set_font( font_array[ 
			GlobalUserSettings.get_current_font_index() ] )


func populate_font_list() -> void:
	print( GlobalUserSettings.get_current_language() )
	font_array = GlobalTheme.font_list[
			GlobalUserSettings.get_current_language() ].keys()


func set_language( index: int ) -> void:
	var full_name: String = nOptionButtonLanguages.get_item_text(
			max( index, 0 ) )
	GlobalUserSettings.set_new_language( 
			GlobalUserSettings.languages[ full_name ] )
	GlobalUserSettings.save_settings()
	populate_font_list()
	set_font( 0 )


func populate_languages() -> void:
	for full_name in GlobalUserSettings.languages.keys():
		nOptionButtonLanguages.add_item( full_name )
	nOptionButtonLanguages.select( 0 )


func update_from_load() -> void:
	var current_language: String = GlobalUserSettings.get_current_language()
	#	Game wouldn't set the right font after loading from settings.
	var current_font_index: int = GlobalUserSettings.get_current_font_index()
	if( current_language == "" ):
		return
	#	End defensive return: Current language not set/is default.
	var languages: Array = GlobalUserSettings.get_language_codes()
	var language_index: int = languages.find( current_language )
	nOptionButtonLanguages.select( language_index )
	set_language( language_index )
	#	I am having trouble finding a non-gross way of doing this.
	set_font( current_font_index )


func _ready() -> void:
	populate_languages()
