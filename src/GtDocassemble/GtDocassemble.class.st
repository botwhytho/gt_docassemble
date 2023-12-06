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

{ #category : #accessing }
GtDocassemble >> gtDependenciesFor: aView [
	<gtView>
	| allYamlFiles inclusionDocuments dependencyMapping |
	allYamlFiles := (self folder / 'docassemble') allFiles
			select: [ :each | each extension = 'yml' ].
	inclusionDocuments := allYamlFiles
			collect: [ :each | 
				| aYamlView |
				aYamlView := (YAMLParser parse: each contents) object.
				each
					-> ((aYamlView select: [ :aDocument | aDocument keys includes: 'include' ])
							collect: [ :aDocument | aDocument at: 'include' ]) ].
	dependencyMapping := (inclusionDocuments
			collect: [ :anAssociation | 
				anAssociation key
					-> (anAssociation value flatten
							collect: [ :aDependency | 
								anAssociation key parent / aDependency
									ifExists: [ :found | found ]
									ifAbsent: [ aDependency ] ]) ])
			select: [ :anAssociation | anAssociation value isNotEmpty ].

	^ aView mondrian
		title: 'Dependencies';
		priority: 1;
		painting: [ :aMondrian | 
			aMondrian nodes
				stencil: [ :each | 
					BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: (each isString ifTrue: [ each ] ifFalse: [ each basename ]) ];
				with: allYamlFiles asSet , (dependencyMapping collect: #value) flatten.
			aMondrian edges
				fromRightCenter;
				toLeftCenter;
				stencil: [ :aBorder :fromElement :toElement | BlSigmoidElement new border: (BlBorder paint: (Color gray alpha: 0.5) width: 1) ];
				connect: dependencyMapping
					from: #key
					toAll: #value.
			aMondrian layout horizontalDominanceTree
				levelDistance: 20;
				nodeDistance: 20;
				treesDistance: 20 ]
]
