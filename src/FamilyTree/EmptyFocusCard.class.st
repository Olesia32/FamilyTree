Class {
	#name : 'EmptyFocusCard',
	#superclass : 'EmptyCard',
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'layout' }
EmptyFocusCard >> defaultLayout [ 
^ SpBoxLayout new
  hAlignCenter;
  vAlignCenter;
  add: addButton;
yourself 
]

{ #category : 'initialization' }
EmptyFocusCard >> initializePresenters [

	super initializePresenters.
	self removeStyle: 'yellow'.
	self addStyle: 'green'.
	addButton removeStyle: 'addButtonYellowStyle'.
	addButton addStyle: 'addButtonGreenStyle'.
	addButton icon: ((self iconNamed: #add) scaledToSize: 50 @ 50)
]
