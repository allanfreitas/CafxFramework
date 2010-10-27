package com.riacycle.core.reflection
{
	import mx.collections.ArrayCollection;

	public class Annotation
	{
		
		public var name:String;
		public var maps:ArrayCollection;
		
		public function getAnnotationMap(key:String):AnnotationMap{
			for (var i:int=0 ; i < maps.length ; i++){
				var map:AnnotationMap = maps.getItemAt(i) as AnnotationMap;
				if (map.key == key) return map;
			}
			return null;
		}
		
	}
}