Class {
	#name : 'Card',
	#superclass : 'SpPresenter',
	#instVars : [
		'person',
		'name',
		'yearsOfLife',
		'personPhoto'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'layout' }
Card >> defaultLayout [

	^ SpGridLayout new
		  add: name at: 1 @ 1;
		  add: yearsOfLife at: 1 @ 2;
		  add: '' at: 1 @ 3;
		  add: personPhoto at: 2 @ 1 span: 1 @ 3;
		  yourself
]

{ #category : 'initialization' }
Card >> initialize [
super initialize.
person := Person new.
self addStyle: 'yellow'.
]

{ #category : 'initialization' }
Card >> initializePresenters [

	name := self newLabel.
	yearsOfLife := self newLabel.
	personPhoto := self newImage.
	self initializeStyles
]

{ #category : 'initialization' }
Card >> initializeStyles [

	name addStyle: 'title'.
	yearsOfLife addStyle: 'h4'.
	personPhoto addStyle: 'photo'
]

{ #category : 'accessing' }
Card >> person: aPerson [

	| image |
	person := aPerson.
	name label: person fullName.
	yearsOfLife label: person yearsOfLife.
	person mainPhoto
		ifNotNil: [ image := Form fromFileNamed: person mainPhoto ]
		ifNil: [
			image := person gender = 'male'
				         ifTrue: [
					         Form fromFileNamed:
						         'C:\Users\olesy\OneDrive\Документи\GitHub\ProgramEngineeringProject-\FamilyTree\FamilyTree.WPF\Images\man.png' ]
				         ifFalse: [
					         Form fromFileNamed:
						         'C:\Users\olesy\OneDrive\Документи\GitHub\ProgramEngineeringProject-\FamilyTree\FamilyTree.WPF\Images\woman.png' ] ].
	image := image scaledToSize: 50 @ 70.
	personPhoto image: image.
	^ self defaultLayout
]
