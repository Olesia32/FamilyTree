Class {
	#name : 'EditPersonPresenter',
	#superclass : 'AddPersonPresenter',
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
EditPersonPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Редагувати особу';
		initialExtent: 450 @ 500
]

{ #category : 'accessing' }
EditPersonPresenter >> person: arg1 [

	person := arg1.
	firstName text: arg1 firstName.
	lastName text: arg1 lastName.
	arg1 gender = 'male' ifFalse: [  ].
	birthDate date: arg1 birthDate.
	birthPlace text: arg1 birthPlace.
	deathDate date: arg1 deathDate.
	deathPlace text: arg1 deathPlace
]
