Class {
	#name : 'RegisterPresenter',
	#superclass : 'InputPersonInformationPresenter',
	#instVars : [
		'login',
		'password'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
RegisterPresenter >> connectPresenters [ 
	submit action: [
		(login text isEmpty or: [
			 password text isEmpty or: [
				 firstName text isEmpty or: [ lastName text isEmpty ] ] ])
			ifFalse: [
				(application repository getUserByLogin: login text)
					ifNil: [
						| mainPersonId treeId person tree |
						person := Person new.
						tree := Tree new.
						person
							firstName: firstName text;
							lastName: lastName text;
							birthDate: birthDate date;
							birthPlace: birthPlace text.
						tree userId: login text.
						application repository addUser: (User new
								 login: login text;
								 password: password text).
						treeId := application repository addTree: tree.
						mainPersonId := application repository addPerson:
							                (person tree: treeId).
						application repository updateTree:
							(tree mainPerson: mainPersonId).
						application openMainPresenter: treeId ]
					ifNotNil: [
						errorLabel
							label: login text , ' вже існує. Оберіть інший логін.';
							show ] ]
			ifTrue: [
				errorLabel
					label: 'Заповніть усі необхідні поля';
					show ] ].

	backButton action: [
		| window |
		window := self window.
		window close.
		application openLoginPresenter ]
]

{ #category : 'layout' }
RegisterPresenter >> defaultLayout [

	^ SpBoxLayout newVertical
		  vAlignCenter;
		  add: (SpGridLayout new
				   add: 'Логін:' at: 1 @ 1;
				   add: login at: 2 @ 1 span: 2 @ 1;
				   add: 'Пароль:' at: 1 @ 2;
				   add: password at: 2 @ 2 span: 2 @ 1;
				   add: 'Ім`я:' at: 1 @ 3;
				   add: firstName at: 2 @ 3 span: 2 @ 1;
				   add: 'Прізвище:' at: 1 @ 4;
				   add: lastName at: 2 @ 4 span: 2 @ 1;
				   add: 'Стать:' at: 1 @ 5;
				   add: (SpBoxLayout newHorizontal
						    add: male;
						    add: female;
						    yourself)
				   at: 2 @ 5 span: 2 @ 1;
				   add: 'Дата народження:' at: 1 @ 6;
				   add: birthDate at: 2 @ 6 span: 2 @ 1;
				   add: 'Місце народження:' at: 1 @ 7;
				   add: birthPlace at: 2 @ 7 span: 2 @ 1;
				   add: errorLabel at: 1 @ 8 span: 2 @ 1;
				   beColumnNotHomogeneous;
				   yourself)
		  withConstraints: [ :constr |
			  constr
				  height: 300;
				  expand: false ];
		  add: (SpBoxLayout newLeftToRight
				   hAlignCenter;
				   spacing: 20;
				   add: submit expand: false;
				   add: backButton expand: false;
				   yourself)
		  expand: false;
		  yourself
]

{ #category : 'initialization' }
RegisterPresenter >> initializePresenters [
   super initializePresenters.
	login := self newTextInput.
	password := self newTextInput
		            bePassword;
		            yourself.
	self initializeStyles
]

{ #category : 'initialization' }
RegisterPresenter >> initializeStyles [ 
   super initializeStyles.
   login addStyle: 'lightGray'.
	password addStyle: 'lightGray'.
]

{ #category : 'initialization' }
RegisterPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Реєстрація';
		initialExtent: 450 @ 500
]
