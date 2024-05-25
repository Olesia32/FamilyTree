Class {
	#name : 'User',
	#superclass : 'Object',
	#instVars : [
		'login',
		'password',
		'trees'
	],
	#category : 'FamilyTree',
	#package : 'FamilyTree'
}

{ #category : 'initialization' }
User >> initialize [ 
trees := OrderedCollection new.
]

{ #category : 'accessing' }
User >> login [
^ login
]

{ #category : 'accessing' }
User >> login: aLogin [
login := aLogin 
]

{ #category : 'accessing' }
User >> password [
^password 
]

{ #category : 'accessing' }
User >> password: aPassword [
password := aPassword 
]
