Class {
	#name : 'FamilyTreeConfiguration',
	#superclass : 'SpMorphicConfiguration',
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'configuring' }
FamilyTreeConfiguration >> configure: anApplication [

	super configure: anApplication.
	self addStyleSheetFromString: self customStyleSheet
]

{ #category : 'as yet unclassified' }
FamilyTreeConfiguration >> customStyleSheet [

	^ '
	.application [
		.buttonStyle [ Geometry { #width: 180, #height: 40 } ],
		.buttonGreenStyle [ Draw { #backgroundColor: #8BA385}, Geometry { #width: 180, #height: 50 } ],
		.cellStyle [ Geometry { #width: 80, #height: 80 }, Font { #size: 20, #bold: true}],
		.green [ Draw { #backgroundColor: #CDD7CB}, Geometry { #width: 320, #height: 240 }],
		.red [ Draw { #color: #red}],
		.yellow [ Draw { #backgroundColor: #fffacd}, Geometry { #width: 180, #height: 100 }],
		.photo [ Geometry { #width: 70, #height: 100 }],
		.white [ Draw { #backgroundColor: #white} ],
		.lightGray [ Draw { #backgroundColor: #d7d7d7}, Geometry { #height: 35 } ],
		.lightGreen [ Draw { #backgroundColor: #778D45 } ],
		.lightRed [ Draw { #backgroundColor: #FA8072 } ],
		.lightPurple [ Draw { #backgroundColor: #7B68EE } ],
		.title [ Font { #size: 72, #bold: true},
			Geometry { #height: Reset, #width: Reset } ]],
	   .smallTitle [ Font { #size: 16, #bold: true},
			Geometry { #height: Reset, #width: Reset } ]],
	   .h4 [ Font { #size: 14}],
	   .p [ Font { #size: 12}]
'
]
