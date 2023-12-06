Class {
	#name : #GtDocassembleCodeDocument,
	#superclass : #Object,
	#instVars : [
		'code'
	],
	#category : #GtDocassemble
}

{ #category : #'*GtDocassemble' }
GtDocassembleCodeDocument class >> withCode: anObject [
	^ self new code: anObject
]

{ #category : #accessing }
GtDocassembleCodeDocument >> code [
	^ code
]

{ #category : #accessing }
GtDocassembleCodeDocument >> code: anObject [
	code := anObject
]

{ #category : #accessing }
GtDocassembleCodeDocument >> gtCodeFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Python';
		priority: 1;
		aptitude: [ BrGlamorousCodeEditorAptitude ];
		styler: [ PythonParser gtStyler ];
		text: [ self code ]
]
