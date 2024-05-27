Class {
	#name : 'AddPersonPresenter',
	#superclass : 'InputPersonInformationPresenter',
	#instVars : [
		'deathDate',
		'deathPlace',
		'photo',
		'photoButton',
		'person'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
AddPersonPresenter >> connectPresenters [

	submit action: [
		(firstName text isNotEmpty and: [ lastName text isNotEmpty ])
			ifTrue: [
				| gender |
				gender := male state
					          ifTrue: [ 'male' ]
					          ifFalse: [ 'female' ].
				person := Person new.
				person := person
					          firstName: firstName text;
					          lastName: lastName text;
					          birthDate: birthDate date;
					          birthPlace: birthPlace text;
					          deathDate: deathDate date;
					          deathPlace: deathPlace text;
					          gender: gender.

				self window close ]
			ifFalse: [
				errorLabel
					label: 'Заповніть усі необхідні поля';
					show ] ].
	photoButton action: [
    | fileDialog selectedPath fileContent fileExtension |
    
    "Створюємо новий екземпляр FileDialogWindow"
    fileDialog := FileDialogWindow new.
    
    "Відкриваємо діалогове вікно"
    fileDialog open.
    
    "Отримуємо шлях до вибраного файлу"
    selectedPath := fileDialog selectedPathName.
    self halt.
    selectedPath ifNotNil: [
        "Отримуємо розширення файлу"
        fileExtension := selectedPath findTokens: '.' last.
        
        "Перевіряємо, чи є файл зображенням"
        ((#('jpg' 'jpeg' 'png' 'gif' 'bmp') includes: fileExtension) ifTrue: [
            "Завантажуємо зображення з файлу"
            fileContent := Form fromFileNamed: selectedPath.
            
            "Масштабуємо зображення до потрібного розміру"
            fileContent := fileContent scaledToSize: 70 @ 100.
            "Встановлюємо зображення у компонент photo"
            photo image: fileContent
        ])
    ].
].
]

{ #category : 'layout' }
AddPersonPresenter >> defaultLayout [

	| tmp1 tmp2 tmp3 tmp5 |
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
	tmp5 := SpBoxLayout newLeftToRight.
	tmp5
		hAlignCenter;
		add: submit expand: false.
	tmp1 add: tmp5 yourself expand: false.
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
	photoButton addStyle: 'buttonGreenStyle'
]

{ #category : 'initialization' }
AddPersonPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Додати особу';
		initialExtent: 450 @ 500
]

{ #category : 'accessing' }
AddPersonPresenter >> person [
^ person
]

{ #category : 'accessing' }
AddPersonPresenter >> person: aPerson [
person := aPerson 
]
