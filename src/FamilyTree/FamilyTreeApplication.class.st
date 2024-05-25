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
FamilyTreeApplication >> openEditPersonPresenter [

	| window |
	window := (self newPresenter: EditPersonPresenter) open.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'as yet unclassified' }
FamilyTreeApplication >> openEditPersonPresenter: aPerson [

	| window |
	window := (self newPresenter: EditPersonPresenter) open.
	window presenter person: aPerson.
	window window
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
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
	window := self newPresenter: FamilyTreePresenter.
	window treeId: (repository getTreeById: aTree ) mainPerson.
	window open.
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
