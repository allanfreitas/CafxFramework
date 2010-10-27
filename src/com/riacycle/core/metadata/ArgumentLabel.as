package com.riacycle.core.metadata
{
	import com.riacycle.core.reflection.Annotation;
	import com.riacycle.core.reflection.AnnotationMap;

	public class ArgumentLabel implements IArgument
	{
				
		private var arg:IArgument;
		
		public function setNext(arg:IArgument):void{
			this.arg = arg;
		}
		
		public function execute(component:Object,annotation:Annotation):void
		{
			component.label = annotation.getAnnotationMap("label").value.toString();
			if (arg != null){
				arg.execute(component,annotation);
			}
		}
	}
}