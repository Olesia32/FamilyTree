Class {
	#name : 'FocusCard',
	#superclass : 'Card',
	#instVars : [
		'birthDate',
		'birthPlace',
		'deathDate',
		'deathPlace',
		'delete',
		'update'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
FocusCard >> connectPresenters [

	delete action: [ owner deletePerson: person ].
	update action: [ owner updatePerson: person ]
]

{ #category : 'layout' }
FocusCard >> defaultLayout [

	| tmp1 |
	tmp1 := SpGridLayout new.
	tmp1
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
		add: delete at: 1 @ 7;
		add: update at: 2 @ 7;
		add: personPhoto at: 3 @ 1 span: 1 @ 7.
	^ tmp1 yourself
]

{ #category : 'initialization' }
FocusCard >> initializePresenters [

	super initializePresenters.
	birthDate := self newLabel.
	birthPlace := self newLabel.
	deathDate := self newLabel.
	deathPlace := self newLabel.
	delete := self newButton label: 'Видалити'.
	delete addStyle: 'buttonGreenStyle'.
	update := self newButton label: 'Редагувати'.
	update addStyle: 'buttonGreenStyle'.
	self initializeStyles
]

{ #category : 'initialization' }
FocusCard >> initializeStyles [

	self addStyle: 'green'.
	name
		removeStyle: 'smallTitle';
		addStyle: 'title'
]

{ #category : 'accessing' }
FocusCard >> person: arg1 [

	| tmp1 |
	person := arg1.
	name label: person fullName.
	name help: person fullName.
	yearsOfLife label: person yearsOfLife.
	person birthDate
		ifNil: [ birthDate label: 'Невідомо' ]
		ifNotNil: [ birthDate label: person birthDate asString; help:  person birthDate asString].
	person birthPlace
		ifNil: [ birthPlace label: 'Невідомо' ]
		ifNotNil: [ birthPlace label: person birthPlace; help: person birthPlace ].
	person deathDate
		ifNil: [ deathDate label: 'Невідомо' ]
		ifNotNil: [ deathDate label: person deathDate asString; help: person deathDate asString ].
	person deathPlace
		ifNil: [ deathPlace label: 'Невідомо' ]
		ifNotNil: [ deathPlace label: person deathPlace; help: person deathPlace].
	person mainPhoto
		ifNil: [
			tmp1 := person gender = 'male'
				        ifTrue: [
					        Form fromFileNamed:
						        'C:\Users\olesy\OneDrive\Документи\GitHub\ProgramEngineeringProject-\FamilyTree\FamilyTree.WPF\Images\man.png' ]
				        ifFalse: [
					        Form fromFileNamed:
						        'C:\Users\olesy\OneDrive\Документи\GitHub\ProgramEngineeringProject-\FamilyTree\FamilyTree.WPF\Images\woman.png' ] ]
		ifNotNil: [ tmp1 := Form fromFileNamed: person mainPhoto ].
	tmp1 := tmp1 scaledToSize: 70 @ 100.
	personPhoto image: tmp1.
	^ self defaultLayout
]
