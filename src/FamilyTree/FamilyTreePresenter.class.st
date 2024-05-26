Class {
	#name : 'FamilyTreePresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'mainPersonId',
		'maleFocus',
		'femaleFocus',
		'maleFather',
		'maleMother',
		'femaleFather',
		'femaleMother',
		'children',
		'childrenPanel'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'adding' }
FamilyTreePresenter >> addApplication [

	maleFocus application: self application.
	maleFocus owner: self.
	femaleFocus application: self application.
	femaleFocus owner: self.
	maleFather application: self application.
	maleFather owner: self.
	maleMother application: self application.
	maleMother owner: self.
	femaleFather application: self application.
	femaleFather owner: self.
	femaleMother application: self application.
	femaleMother owner: self.
	childrenPanel allPresenters do: [ :child |
		child application: self application.
		child owner: self ]
]

{ #category : 'initialization' }
FamilyTreePresenter >> connectPresenters [ 
(maleFather class = Card) ifTrue: [ maleFather adapter widget on: #mouseUp send: #handleMouseUp to: self. ]
]

{ #category : 'layout' }
FamilyTreePresenter >> defaultLayout [

	^ SpBoxLayout newHorizontal
		  vAlignCenter;
		  add: (SpBoxLayout newVertical
				   spacing: 10;
				   add: (SpBoxLayout newLeftToRight
						    hAlignCenter;
						    spacing: 40;
						    add: maleFather expand: false;
						    add: maleMother expand: false;
						    add: '' withConstraints: [ :constr |
							    constr
								    padding: 20;
								    expand: false ];
						    add: femaleFather expand: false;
						    add: femaleMother expand: false;
						    yourself)
				   withConstraints: [ :constr |
					   constr
						   padding: 40;
						   expand: false ];
				   add: (SpBoxLayout newLeftToRight
						    hAlignCenter;
						    spacing: 150;
						    add: maleFocus expand: false;
						    
						    add: femaleFocus expand: false;
						    yourself)
				   expand: false fill: false;
				   add: childrenPanel withConstraints: [ :constr |
				   constr
					   padding: 40;
					   expand: false ];
				   yourself);
		  yourself
]

{ #category : 'as yet unclassified' }
FamilyTreePresenter >> deletePerson: aPerson [

	| dialog mainPerson |
	mainPerson := (application repository getTreeById: aPerson tree)
		              mainPerson.
	mainPerson = aPerson id ifTrue: [ ^ self ].
	dialog := UIManager default confirm:
		          'Ви впевнені, що хочете видалити?'.
	dialog ifFalse: [ ^ self ].
	application repository deletePerson: aPerson.
	self redrawTree: mainPerson
]

{ #category : 'events - processing' }
FamilyTreePresenter >> handleMouseUp: anEvent [

	Transcript
		show: 'Натиснуто на Morph!';
		cr
]

{ #category : 'initialization' }
FamilyTreePresenter >> initialize [ 
super initialize 
]

{ #category : 'initialization' }
FamilyTreePresenter >> initializePresenters [

	self addStyle: 'white'.
]

{ #category : 'as yet unclassified' }
FamilyTreePresenter >> redrawTree: aFocusPersonId [

	| focusPerson spouse focusFather focusMother spouseFather spouseMother |
	aFocusPersonId ifNotNil: [
		focusPerson := application repository getPersonById: aFocusPersonId.
		focusPerson spouseId ifNotNil: [
			spouse := application repository getPersonById:
				          focusPerson spouseId ].
		focusPerson fatherId ifNotNil: [
			focusFather := application repository getPersonById:
				               focusPerson fatherId ].
		focusPerson motherId ifNotNil: [
			focusMother := application repository getPersonById:
				               focusPerson motherId ].
		spouse ifNotNil: [
			spouse fatherId ifNotNil: [
				spouseFather := application repository getPersonById:
					                spouse fatherId ].
			spouse motherId ifNotNil: [
				spouseMother := application repository getPersonById:
					                spouse motherId ] ].
		focusPerson gender = 'male'
			ifTrue: [
				maleFocus := FocusCard new.
				maleFocus person: focusPerson.
				focusFather
					ifNotNil: [
						maleFather := Card new.
						maleFather person: focusFather ]
					ifNil: [
						maleFather := EmptyCard new.
						maleFather ].
				focusMother
					ifNotNil: [
						maleMother := Card new.
						maleMother person: focusMother ]
					ifNil: [
						maleMother := EmptyCard new.
						maleMother ].
				spouse
					ifNotNil: [
						femaleFocus := FocusCard new.
						femaleFocus person: spouse.
						spouseFather
							ifNotNil: [
								femaleFather := Card new.
								femaleFather person: spouseFather ]
							ifNil: [ femaleFather := EmptyCard new ].
						spouseMother
							ifNotNil: [
								femaleMother := Card new.
								femaleMother person: spouseFather ]
							ifNil: [ femaleMother := EmptyCard new ] ]
					ifNil: [
						femaleFocus := EmptyFocusCard new.
						femaleFather := EmptyCard new.
						femaleMother := EmptyCard new ] ]
			ifFalse: [
				femaleFocus := FocusCard new.
				femaleFocus person: focusPerson.
				focusFather
					ifNotNil: [
						femaleFather := Card new.
						femaleFather person: focusFather ]
					ifNil: [ femaleFather := EmptyCard new ].
				focusMother
					ifNotNil: [
						femaleMother := Card new.
						femaleMother person: focusMother ]
					ifNil: [ femaleMother := EmptyCard new ].
				spouse
					ifNotNil: [
						maleFocus := FocusCard new.
						maleFocus person: spouse.
						spouseFather
							ifNotNil: [
								maleFather := Card new.
								maleFather person: spouseFather ]
							ifNil: [ maleFather := EmptyCard new.].
						spouseMother
							ifNotNil: [
								maleMother := Card new.
								maleMother person: spouseMother ]
							ifNil: [ maleMother := EmptyCard new.] ]
					ifNil: [
						maleFocus := EmptyFocusCard new.
						maleFather := EmptyCard new.
						maleMother := EmptyCard new ] ].
		children := application repository getChildrenForPerson:
			            aFocusPersonId.
		childrenPanel := SpBoxLayout newLeftToRight
			                 hAlignCenter;
			                 spacing: 40;
			                 yourself.
		children do: [ :child |
			| card |
			card := Card new.
			card person: child.
			childrenPanel add: card expand: false ].
		childrenPanel add: EmptyCard new.
		owner redraw: self defaultLayout ]
]

{ #category : 'accessing' }
FamilyTreePresenter >> treeId: id [
   mainPersonId := id.
	self redrawTree: id
]

{ #category : 'as yet unclassified' }
FamilyTreePresenter >> updatePerson: aPerson [

	owner openEditPersonPresenter: aPerson 
]
