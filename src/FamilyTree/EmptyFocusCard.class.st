Class {
	#name : 'EmptyFocusCard',
	#superclass : 'SpPresenter',
	#instVars : [
		'addButton'
	],
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
   self addStyle: 'green'.
	addButton := self newButton label: 'Додати'
]
