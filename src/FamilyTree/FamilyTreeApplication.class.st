Class {
	#name : 'FamilyTreeApplication',
	#superclass : 'SpApplication',
	#instVars : [
		'repository'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
FamilyTreeApplication >> initialize [

	super initialize.
	self useBackend: #Morphic with: FamilyTreeConfiguration new.
	repository := FamilyTreeRepository new.
	
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openAddPersonPresenter [

	| window |
	window := (self newPresenter: AddPersonPresenter ) open.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openEditPersonPresenter: aPerson [

	| window |
	window := self newPresenter: EditPersonPresenter.
	window person: aPerson.
	window := window openDialog.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox.
	window okAction: [ window windows at: 1 updatePerson ]
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openLoginPresenter [
	| window |
	window := (self  newPresenter: LoginPresenter) open.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openMainPresenter: aTree [

	| window |
	window := self newPresenter: MainWindowPresenter.
	window treeId: aTree .
	window := window open.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openRegisterPresenter [

	| window |
	window := (self newPresenter: RegisterPresenter) open.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'accessing' }
FamilyTreeApplication >> repository [
^ repository 
]

{ #category : 'running' }
FamilyTreeApplication >> start [

	self openLoginPresenter 
]
