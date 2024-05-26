Class {
	#name : 'Card',
	#superclass : 'SpPresenter',
	#instVars : [
		'person',
		'name',
		'yearsOfLife',
		'personPhoto',
		'go'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
Card >> connectPresenters [ 
go action: [ owner redrawTree: (person id) ]
]

{ #category : 'layout' }
Card >> defaultLayout [

	^ SpGridLayout new
		  add: name at: 1 @ 1;
		  add: yearsOfLife at: 1 @ 2;
		  add: go at: 1 @ 3;
		  add: personPhoto at: 2 @ 1 span: 1 @ 3;
		  yourself
]

{ #category : 'initialization' }
Card >> initializePresenters [

	name := self newLabel.
	yearsOfLife := self newLabel.
	personPhoto := self newImage.
	go := self newButton label: 'Перейти'.
	self initializeStyles
]

{ #category : 'initialization' }
Card >> initializeStyles [

	self addStyle: 'yellow'.
	name addStyle: 'smallTitle'.
	yearsOfLife addStyle: 'h4'.
	personPhoto addStyle: 'photo'.
	go addStyle: 'goButtonStyle'.
]

{ #category : 'accessing' }
Card >> person [

	^ person
]

{ #category : 'accessing' }
Card >> person: arg1 [

	| tmp1 |
	person := arg1.
	name label: person fullName.
	yearsOfLife label: person yearsOfLife.
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
	tmp1 := tmp1 scaledToSize: 50 @ 70.
	personPhoto image: tmp1.
	^ self defaultLayout
]
