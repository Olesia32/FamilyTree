Class {
	#name : 'MainWindowPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'treeId',
		'tree',
		'list'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'layout' }
MainWindowPresenter >> defaultLayout [

	^ SpScrollableLayout with: tree yourself .
]

{ #category : 'initialization' }
MainWindowPresenter >> initializePresenters [

	tree := FamilyTreePresenter new.
]

{ #category : 'initialization' }
MainWindowPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Дерево Роду';
		initialExtent: 1300 @ 700
]

{ #category : 'accessing' }
MainWindowPresenter >> treeId: anId [

	treeId := anId.
	tree application: application.
	tree redrawTree: (application repository getTreeById: treeId) mainPerson
]
