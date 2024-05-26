Class {
	#name : 'MainWindowPresenter',
	#superclass : 'SpPresenter',
	#instVars : [
		'treeId',
		'tree',
		'list',
		'mainLabel'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
MainWindowPresenter >> connectPresenters [

	list whenSelectionChangedDo: [
		list selectedItem ifNotNil: [ tree redrawTree: list selectedItem id ] ]
]

{ #category : 'layout' }
MainWindowPresenter >> defaultLayout [

	| tmp2 |
	tmp2 := SpBoxLayout newLeftToRight.
	tmp2
		add: (SpScrollableLayout with: tree yourself);
		add: (SpBoxLayout newVertical
		       hAlignCenter;
				 spacing: 20;
				 add: mainLabel expand: false;
				 add: list;
				 yourself)
		withConstraints: [ :arg1 | arg1 width: 200 ].
	^ tmp2 yourself
]

{ #category : 'initialization' }
MainWindowPresenter >> initializePresenters [

	tree := FamilyTreePresenter new.
	tree owner: self.
	tree application: application .
	list := self newFilteringList.
	mainLabel := self newLabel label: 'Список осіб'.
	self initializeStyles
]

{ #category : 'initialization' }
MainWindowPresenter >> initializeStyles [

	list addStyle: 'list'.
	mainLabel addStyle: 'title'
	
]

{ #category : 'initialization' }
MainWindowPresenter >> initializeWindow: arg1 [

	arg1
		title: 'Дерево Роду';
		initialExtent: 1300 @ 700
]

{ #category : 'as yet unclassified' }
MainWindowPresenter >> openEditPersonPresenter: arg1 [

	| tmp1 tmp3 |
	tmp1 := application newPresenter: EditPersonPresenter.
	tmp1 person: arg1.
	tmp1 := tmp1 open.
	tmp3 := tmp1 window.
	tmp3
		beUnresizeable;
		removeExpandBox;
		removeCollapseBox;
		removeMenuBox
]

{ #category : 'as yet unclassified' }
MainWindowPresenter >> redraw: arg1 [

	tree layout: arg1.
	self defaultLayout
]

{ #category : 'accessing' }
MainWindowPresenter >> treeId: arg1 [

	| tmp1 tmp3 |
	treeId := arg1.
	tmp1 := (application repository getTreeById: arg1) mainPerson.
	list items: (application repository getAllPersonsForTreeId: treeId).
	tmp3 := list listPresenter.
	tmp3
		display: [ :arg2 | ' ' , arg2 fullName , ' ' , arg2 yearsOfLife ];
		sortingBlock: [ :arg3 :arg4 | arg3 fullName < arg4 fullName ].
	tmp3 selectItem: (application repository getPersonById: tmp1).
	tree
		application: application;
		redrawTree: tmp1
]
