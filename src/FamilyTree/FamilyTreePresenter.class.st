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
						    spacing: 20;
						    add: maleFocus expand: false;
						    add: (self newMorph morph: (Morph new
										      color: Color black;
										      height: 1;
										      width: 100))
						    expand: false;
						    yourself)
				   expand: false fill: false;
				   add: childrenPanel withConstraints: [ :constr |
				   constr
					   padding: 40;
					   expand: false ];
				   yourself);
		  yourself
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

	| focusPerson spouse focusFather focusMother spouseFather spouseMother children |
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
				maleFocus := FocusCard new person: focusPerson.
				focusFather
					ifNotNil: [ maleFather := Card new person: focusFather ]
					ifNil: [ maleFather := EmptyCard ].
				focusMother
					ifNotNil: [ maleMother := Card new person: focusMother ]
					ifNil: [ maleMother := EmptyCard ].
				spouse
					ifNotNil: [
						femaleFocus := FocusCard new person: spouse.
						femaleFather := spouseFather
							                ifNotNil: [ Card new person: spouseFather ]
							                ifNil: [ EmptyCard ].
						femaleMother := spouseMother
							                ifNotNil: [ Card new person: spouseMother ]
							                ifNil: [ EmptyCard ] ]
					ifNil: [
						femaleFocus := EmptyFocusCard.
						femaleFather := EmptyCard.
						femaleMother := EmptyCard ] ]
			ifFalse: [
				femaleFocus := FocusCard new person: focusPerson.
				femaleFather := focusFather
					                ifNotNil: [ Card new person: focusFather ]
					                ifNil: [ EmptyCard ].
				focusMother
					ifNotNil: [ femaleMother := Card new person: focusMother ]
					ifNil: [ femaleMother := EmptyCard ].
				spouse
					ifNotNil: [
						maleFocus := FocusCard new person: spouse.
						spouseFather
							ifNotNil: [ maleFather := Card new person: spouseFather ]
							ifNil: [ maleFather := EmptyCard ].
						maleMother := spouseMother
							              ifNotNil: [ Card new person: spouseMother ]
							              ifNil: [ EmptyCard ] ]
					ifNil: [
						maleFocus := EmptyFocusCard.
						maleFather := EmptyCard.
						maleMother := EmptyCard ] ].
		

		^ self defaultLayout ]
]

{ #category : 'accessing' }
FamilyTreePresenter >> treeId: id [
self redrawTree: id
]
