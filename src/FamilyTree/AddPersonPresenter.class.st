Class {
	#name : 'AddPersonPresenter',
	#superclass : 'InputPersonInformationPresenter',
	#instVars : [
		'deathDate',
		'deathPlace',
		'photo',
		'photoButton'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
AddPersonPresenter >> connectPresenters [

	photoButton action: [
		|fileDialogWindow path image|
		fileDialogWindow := FileDialogWindow new.
		fileDialogWindow open.
		fileDialogWindow action: [  path := fileDialogWindow selectedPathName].
		path ifNotNil: [  
		image := Form fromFileNamed: path.
	image := image scaledToSize: 70 @ 100.
	photo image: image. ]]
]

{ #category : 'layout' }
AddPersonPresenter >> defaultLayout [

	| tmp1 tmp2 tmp3|
	tmp1 := SpBoxLayout newVertical.
	tmp1 vAlignCenter.
	tmp2 := SpGridLayout new.
	tmp2
		add: photo at: 1 @ 1;
		add: photoButton at: 2 @ 1;
		add: 'Ім`я:' at: 1 @ 2;
		add: firstName at: 2 @ 2 span: 2 @ 1;
		add: 'Прізвище:' at: 1 @ 3;
		add: lastName at: 2 @ 3 span: 2 @ 1;
		add: 'Стать:' at: 1 @ 4.
	tmp3 := SpBoxLayout newHorizontal.
	tmp3
		add: male;
		add: female.
	tmp2
		add: tmp3 yourself at: 2 @ 4 span: 2 @ 1;
		add: 'Дата народження:' at: 1 @ 5;
		add: birthDate at: 2 @ 5 span: 2 @ 1;
		add: 'Місце народження:' at: 1 @ 6;
		add: birthPlace at: 2 @ 6 span: 2 @ 1;
		add: 'Дата смерті:' at: 1 @ 7;
		add: deathDate at: 2 @ 7 span: 2 @ 1;
		add: 'Місце смерті:' at: 1 @ 8;
		add: deathPlace at: 2 @ 8 span: 2 @ 1;
		add: errorLabel at: 1 @ 9 span: 2 @ 1;
		beColumnNotHomogeneous.
	tmp1 add: tmp2 yourself withConstraints: [ :arg1 |
		arg1
			height: 350;
			expand: false ].
	^ tmp1 yourself
]

{ #category : 'initialization' }
AddPersonPresenter >> initializePresenters [

	super initializePresenters.
	deathDate := SpDatePresenter new.
	deathPlace := self newTextInput.
	photo := self newImage.
	photoButton := self newButton label: 'Обрати фото'.
	submit label: 'Зберегти'.
	self initializeStyles
]

{ #category : 'initialization' }
AddPersonPresenter >> initializeStyles [

	super initializeStyles.
	deathDate addStyle: 'lightGray'.
	deathPlace addStyle: 'lightGray'.
	photoButton addStyle: 'buttonGreenStyle'.
]

{ #category : 'initialization' }
AddPersonPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Додати особу';
		initialExtent: 450 @ 500
]
