Class {
	#name : 'LoginPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'login',
		'password',
		'submit',
		'register',
		'errorLabel',
		'mainLabel',
		'image'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
LoginPresenter >> connectPresenters [

	submit action: [
		(login text isEmpty or: [ password text isEmpty ])
			ifTrue: [
				errorLabel
					label: 'Заповніть усі поля';
					show ]
			ifFalse: [
				| user |
				user := application repository getUserByLogin: login text.
				(user notNil and: [ password text = user password ])
					ifTrue: [
						| window treeId |
						window := self window.
						window close.
						treeId := (application repository getTreeByUserLogin: login text) id.
						application openMainPresenter: treeId ]
					ifFalse: [
						errorLabel
							label: 'Неправильний логін або пароль';
							show ] ] ].

	register action: [
		| window |
		window := self window.
		window close.
		application openRegisterPresenter ].
	login whenEditableChangedDo: [ errorLabel label: '' ]
]

{ #category : 'layout' }
LoginPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  spacing: 20;
		  add: (SpBoxLayout newVertical
				   hAlignCenter;
				   add: image withConstraints: [ :constr |
					   constr
						   padding: 15;
						   width: 100;
						   height: 140 ];
				   add: mainLabel;
				   yourself)
		  expand: false;
		  add: (SpGridLayout new
				   rowSpacing: 10;
				   add: 'Логін:' at: 1 @ 1;
				   add: login at: 2 @ 1 span: 2 @ 1;
				   add: 'Пароль:' at: 1 @ 2;
				   add: password at: 2 @ 2 span: 2 @ 1;
				   add: errorLabel at: 1 @ 3 span: 2 @ 1;
				   beColumnNotHomogeneous;
				   yourself) withConstraints: [:constr| constr height: 150; expand: false];
			add: (SpBoxLayout newLeftToRight
						    hAlignCenter;
						    spacing: 20;
						    add: submit expand: false;
						    add: register expand: false;
						    yourself) expand: false;
		  yourself
]

{ #category : 'initialization' }
LoginPresenter >> initializePresenters [

	| icon |
	login := self newTextInput.
	password := self newTextInput
		            bePassword;
		            yourself.
	submit := self newButton label: 'Продовжити'.
	errorLabel := self newLabel.
	register := self newButton label: 'Зареєструватися'.
	mainLabel := self newLabel label: 'Дерево Роду'.
	image := self newImage.
	icon := Form fromFileNamed:
		        'C:\Users\olesy\OneDrive\Документи\GitHub\ProgramEngineeringProject-\FamilyTree\FamilyTree.WPF\Images\logo.png'.
	icon := icon scaledToSize: 100 @ 140.
	image image: icon.
	self initializeStyles
]

{ #category : 'initialization' }
LoginPresenter >> initializeStyles [

	self addStyle: 'white'.
	login addStyle: 'lightGray'.
	password addStyle: 'lightGray'.
	submit addStyle: 'buttonGreenStyle'.
	register addStyle: 'buttonGreenStyle'.
	mainLabel addStyle: 'title'.
	errorLabel addStyle: 'red'.
]

{ #category : 'initialization' }
LoginPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Вхід';
		initialExtent: 450 @ 500
]
