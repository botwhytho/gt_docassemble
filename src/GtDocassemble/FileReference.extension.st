Extension { #name : #FileReference }

{ #category : #'*GtDocassemble' }
FileReference >> gtDocAssembleFor: anAction [
	<gtAction>
	(self isDirectory
		and: [ #('docassemble' "'.git'") allSatisfy: [ :each | (self / each) exists ]])
		ifFalse: [ ^ anAction noAction ]
		ifTrue: [ ^ anAction button
				tooltip: 'Docassemble Analysis';
				priority: -1;
				label: 'Docassemble';
				action: [ :aButton | aButton phlow spawnObject: (GtDocassemble inFolder: self) ] ]
]
