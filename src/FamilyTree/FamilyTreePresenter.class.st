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

	maleFocus owner: self.
	maleFocus type: 'maleFocus'.
	femaleFocus owner: self.
	femaleFocus type: 'femaleFocus'.
	maleFather owner: self.
	maleFather type: 'maleFather'.
	maleMother owner: self.
	maleMother type: 'maleMother'.
	femaleFather owner: self.
	femaleFather type: 'femaleFather'.
	femaleMother owner: self.
	femaleMother type: 'femaleMother'.
	childrenPanel allPresenters do: [ :child |
		child owner: self.
		child type: 'child' ]
]

{ #category : 'adding' }
FamilyTreePresenter >> addPerson: aType [

	| dialog |
	dialog := application newPresenter: AddPersonPresenter.
	dialog := dialog open whenClosedDo: [
		          | person personId |
		          person := dialog presenter person.
		          person := person tree: (application repository getPersonById: mainPersonId ) tree.
		          person ifNotNil: [
			          aType = 'maleFocus' ifTrue: [
				          person := person
					                    spouseId: femaleFocus id;
					                    fatherId: maleFather id;
					                    motherId: maleMother id.
				          personId := application repository addPerson: person.
				          femaleFocus ifNotNil: [
					          | spouse |
					          spouse := application repository getPersonById: femaleFocus id.
					          spouse := spouse spouseId: personId ].
				          children do: [ :child |
					          | updatedChild |
					          updatedChild := child fatherId: personId.
					          application repository updatePerson: updatedChild ] ].
			          aType = 'femaleFocus' ifTrue: [
				          person := person
					                    spouseId: maleFocus id;
					                    fatherId: femaleFather id;
					                    motherId: femaleMother id.
				          personId := application repository addPerson: person.
				          maleFocus ifNotNil: [
					          | spouse |
					          spouse := application repository getPersonById: maleFocus id.
					          spouse := spouse spouseId: personId ].
				          children do: [ :child |
					          | updatedChild |
					          updatedChild := child motherId: personId.
					          application repository updatePerson: updatedChild ] ].
			          aType = 'maleMother' ifTrue: [
				          person := person spouseId: maleFather id.
				          personId := application repository addPerson: person.
				          maleFather
					          ifNotNil: [
						          | spouse |
						          spouse := application getPersonById: maleFather id.
						          spouse := spouse spouseId: personId.
						          children := application getChildrenForPerson:
							                      maleFather id.
						          children do: [ :child |
							          | updatedChild |
							          updatedChild := child mother: personId.
							          application repository updatePerson: updatedChild ] ]
					          ifNil: [
						          | child |
						          child := (application repository getPersonById:
							                    maleFocus) motherId: maleMother id.
						          application repository updatePerson: child ] ].
			          aType = 'maleFather' ifTrue: [
				          person := person spouseId: maleMother id.
				          personId := application repository addPerson: person.
				          maleMother
					          ifNotNil: [
						          | spouse |
						          spouse := application getPersonById: maleMother id.
						          spouse := spouse spouseId: personId.
						          children := application getChildrenForPerson:
							                      maleMother id.
						          children do: [ :child |
							          | updatedChild |
							          updatedChild := child fatherId: personId.
							          application repository updatePerson: updatedChild ] ]
					          ifNil: [
						          | child |
						          child := (application repository getPersonById:
							                    maleFocus) fatherId: maleFather id.
						          application repository updatePerson: child ] ].
			          aType = 'femaleMother' ifTrue: [
				          person := person spouseId: femaleFather id.
				          personId := application repository addPerson: person.
				          femaleFather
					          ifNotNil: [
						          | spouse |
						          spouse := application getPersonById: femaleFather id.
						          spouse := spouse spouseId: personId.
						          children := application getChildrenForPerson:
							                      femaleFather id.
						          children do: [ :child |
							          | updatedChild |
							          updatedChild := child motherId: personId.
							          application repository updatePerson: updatedChild ] ]
					          ifNil: [
						          | child |
						          child := (application repository getPersonById:
							                    femaleFocus) motherId: femaleMother id.
						          application repository updatePerson: child ] ].
			          aType = 'femaleFather' ifTrue: [
				          person := person spouseId: femaleMother id.
				          personId := application repository addPerson: person.
				          femaleMother
					          ifNotNil: [
						          | spouse |
						          spouse := application getPersonById: femaleMother id.
						          spouse := spouse spouseId: personId.
						          children := application getChildrenForPerson:
							                      femaleMother id.
						          children do: [ :child |
							          | updatedChild |
							          updatedChild := child fatherId: personId.
							          application repository updatePerson: updatedChild ] ]
					          ifNil: [
						          | child |
						          child := (application repository getPersonById:
							                    femaleFocus) fatherId: femaleFather id.
						          application repository updatePerson: child ] ].
			          aType = 'child' ifTrue: [
				          person := person
					                    fatherId: maleFocus id;
					                    motherId: femaleFocus id.
				          personId := application repository addPerson: person ].
			          self redrawTree: personId ] ]
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
							ifNil: [ maleFather := EmptyCard new ].
						spouseMother
							ifNotNil: [
								maleMother := Card new.
								maleMother person: spouseMother ]
							ifNil: [ maleMother := EmptyCard new ] ]
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
		self addApplication.
		owner redraw: self defaultLayout ]
]

{ #category : 'accessing' }
FamilyTreePresenter >> treeId: id [
   mainPersonId := id.
	self redrawTree: id
]

{ #category : 'as yet unclassified' }
FamilyTreePresenter >> updatePerson: aPerson [

	| dialog |
	dialog := application newPresenter: EditPersonPresenter.
	dialog person: aPerson.
	dialog := dialog open whenClosedDo: [
		          application repository updatePerson:
			          dialog presenter person.
		          self redrawTree: aPerson id ]
]
