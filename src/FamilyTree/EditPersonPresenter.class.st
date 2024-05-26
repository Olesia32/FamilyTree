Class {
	#name : 'EditPersonPresenter',
	#superclass : 'AddPersonPresenter',
	#instVars : [
		'person'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
EditPersonPresenter >> connectPresenters [

	submit action: [
		(firstName text isNotEmpty and: [ lastName text isNotEmpty ])
			ifTrue: [
				| gender |
				gender := male state
					          ifTrue: [ 'male' ]
					          ifFalse: [ 'female' ].
				person := person
					firstName: firstName text;
					lastName: lastName text;
					birthDate: birthDate date;
					birthPlace: birthPlace text;
					deathDate: deathDate date;
					deathPlace: deathPlace text;
					gender: gender.

				application repository updatePerson: person ]
			ifFalse: [
				errorLabel
					label: 'Заповніть усі необхідні поля';
					show ] ]
]

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
