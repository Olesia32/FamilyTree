Class {
	#name : 'InputPersonInformationPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'firstName',
		'lastName',
		'gender',
		'male',
		'female',
		'birthDate',
		'birthPlace',
		'submit',
		'backButton',
		'errorLabel'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
InputPersonInformationPresenter >> initializePresenters [
	firstName := self newTextInput.
	lastName := self newTextInput.
	male := self newRadioButton label: 'Чоловік'.
	female := self newRadioButton label: 'Жінка'.
	male associatedRadioButtons: { female }.
	birthDate := SpDatePresenter new.
	birthPlace := self newTextInput.
	submit := self newButton label: 'Продовжити'.
	backButton := self newButton label: 'Повернутись'.
	errorLabel := self newLabel
]

{ #category : 'initialization' }
InputPersonInformationPresenter >> initializeStyles [

	self addStyle: 'white'.
	firstName addStyle: 'lightGray'.
	lastName addStyle: 'lightGray'.
	birthDate addStyle: 'lightGray'.
	birthPlace addStyle: 'lightGray'.
	submit addStyle: 'buttonGreenStyle'.
	backButton addStyle: 'buttonGreenStyle'.
	errorLabel addStyle: 'red'
]
