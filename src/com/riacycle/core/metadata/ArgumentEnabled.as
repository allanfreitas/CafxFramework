package com.riacycle.core.metadata
{
	import com.riacycle.core.reflection.Annotation;

	public class ArgumentEnabled implements IArgument
	{
		
		private var arg:IArgument;
		
		public function setNext(arg:IArgument):void{
			this.arg = arg;
		}
		
		public function execute(component:Object,annotation:Annotation):void
		{
			component.enabled = annotation.getAnnotationMap("enabled").value as Boolean;
			if (arg != null){
				arg.execute(component,annotation);
			}
		}
	}
}