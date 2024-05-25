Class {
	#name : 'FocusCard',
	#superclass : 'SpPresenter',
	#instVars : [
		'person',
		'name',
		'yearsOfLife',
		'birthDate',
		'birthPlace',
		'deathDate',
		'deathPlace',
		'personPhoto',
		'delete'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'layout' }
FocusCard >> defaultLayout [

	^ SpGridLayout new
						           add: name at: 1 @ 1 span: 2 @ 1;
						           add: yearsOfLife at: 1 @ 2 span: 2 @ 1;
								     add: 'Дата народження:' at: 1 @ 3;
								     add: birthDate at: 2 @ 3;
								     add: 'Місце народження:' at: 1 @ 4;
								     add: birthPlace at: 2 @ 4;
								     add: 'Дата смерті:' at: 1 @ 5;
								     add: deathDate at: 2 @ 5;
								     add: 'Місце смерті:' at: 1 @ 6;
								     add: deathPlace at: 2 @ 6;
								     add: delete at: 1 @ 7 span: 2 @ 1;
								     add: personPhoto at: 3 @ 1 span: 1 @ 7;
								     yourself
]

{ #category : 'initialization' }
FocusCard >> initialize [
super initialize.
person := Person new.
self addStyle: 'green'.
]

{ #category : 'initialization' }
FocusCard >> initializePresenters [

	name := self newLabel.
	yearsOfLife := self newLabel.
	birthDate := self newLabel.
	birthPlace := self newLabel.
	deathDate := self newLabel.
	deathPlace := self newLabel.
	personPhoto := self newImage.
	delete := self newButton
		          color: Color green;
		          label: 'Видалити'.
	self initializeStyles
]

{ #category : 'initialization' }
FocusCard >> initializeStyles [

	name addStyle: 'title'.
	yearsOfLife addStyle: 'h4'.
	birthDate addStyle: 'p'.
	birthPlace addStyle: 'p'.
	deathDate addStyle: 'p'.
	deathPlace addStyle: 'p'.
	personPhoto addStyle: 'photo'.
	delete addStyle: 'buttonStyle'
]

{ #category : 'accessing' }
FocusCard >> person: aPerson [

	| image |
	person := aPerson.
	name label: person fullName.
	yearsOfLife label: person yearsOfLife.
	person birthDate
		ifNotNil: [ birthDate label: person birthDate asString]
		ifNil: [ birthDate label: 'Невідомо' ].
	person birthPlace
		ifNotNil: [ birthPlace label: person birthPlace ]
		ifNil: [ birthPlace label: 'Невідомо' ].
	person deathDate
		ifNotNil: [ deathDate label: person deathDate asString ]
		ifNil: [ deathDate label: 'Невідомо' ].
	person deathPlace
		ifNotNil: [ deathPlace label: person deathPlace ]
		ifNil: [ deathPlace label: 'Невідомо' ].
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
	image := image scaledToSize: 70 @ 100.
	personPhoto image: image.
	^ self defaultLayout
]
