Class {
	#name : #GtDocassemble,
	#superclass : #Object,
	#instVars : [
		'folder'
	],
	#category : #'GtDocassemble-Public'
}

{ #category : #accessing }
GtDocassemble class >> inFolder: aFileReference [
	^ self new folder: aFileReference
]

{ #category : #accessing }
GtDocassemble >> folder [
	^ folder
]

{ #category : #accessing }
GtDocassemble >> folder: aFileReference [
	folder := aFileReference
]
