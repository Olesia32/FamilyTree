Class {
	#name : 'EmptyCard',
	#superclass : 'SpPresenter',
	#instVars : [
		'addButton',
		'type'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
EmptyCard >> connectPresenters [

	addButton action: [ owner addPerson: type .]
]

{ #category : 'layout' }
EmptyCard >> defaultLayout [

	^ SpBoxLayout new
		  hAlignCenter;
		  vAlignCenter;
		  add: addButton;
		  yourself
]

{ #category : 'accessing' }
EmptyCard >> id [
^ nil
]

{ #category : 'initialization' }
EmptyCard >> initializePresenters [

	| tmp2 |
	self addStyle: 'yellow'.
	tmp2 := self newButton.
	tmp2
		borderWidth: 0;
		icon: ((self iconNamed: #add) scaledToSize: 20 @ 20).
	addButton := tmp2 yourself.
	addButton addStyle: 'addButtonYellowStyle'
]

{ #category : 'accessing' }
EmptyCard >> type [
^ type
]

{ #category : 'accessing' }
EmptyCard >> type: aType [
	type := aType
]
