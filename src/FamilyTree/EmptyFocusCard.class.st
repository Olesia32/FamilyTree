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
	self
		removeStyle: 'yellow';
		addStyle: 'green'.
	addButton
		removeStyle: 'addButtonYellowStyle';
		addStyle: 'addButtonGreenStyle';
		icon: ((self iconNamed: #add) scaledToSize: 50 @ 50)
]
