Class {
	#name : 'EmptyCard',
	#superclass : 'SpPresenter',
	#instVars : [
		'addButton'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'layout' }
EmptyCard >> defaultLayout [

	^ SpBoxLayout new
		  hAlignCenter;
		  vAlignCenter;
		  add: addButton;
		  yourself
]

{ #category : 'initialization' }
EmptyCard >> initializePresenters [

	self addStyle: 'yellow'.
	addButton := self newButton
		             borderWidth: 0;
		             icon: ((self iconNamed: #add) scaledToSize: 20 @ 20);
		             yourself.
	addButton addStyle: 'addButtonYellowStyle'
]
