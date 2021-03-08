; ModuleID = 'slice.go'
source_filename = "slice.go"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686--linux"

define internal void @main.init(i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret void
}

define internal i32 @main.sliceLen(i32* %ints.data, i32 %ints.len, i32 %ints.cap, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret i32 %ints.len
}

define internal i32 @main.sliceCap(i32* %ints.data, i32 %ints.len, i32 %ints.cap, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret i32 %ints.cap
}

define internal i32 @main.sliceElement(i32* %ints.data, i32 %ints.len, i32 %ints.cap, i32 %index, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %.not = icmp ult i32 %index, %ints.len
  br i1 %.not, label %lookup.next, label %lookup.throw

lookup.throw:                                     ; preds = %entry
  call void @runtime.lookupPanic(i8* undef, i8* null)
  unreachable

lookup.next:                                      ; preds = %entry
  %0 = getelementptr inbounds i32, i32* %ints.data, i32 %index
  %1 = load i32, i32* %0, align 4
  ret i32 %1
}

declare void @runtime.lookupPanic(i8*, i8*)

define internal { i32*, i32, i32 } @main.sliceAppendValues(i32* %ints.data, i32 %ints.len, i32 %ints.cap, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %varargs = call i8* @runtime.alloc(i32 12, i8* undef, i8* null)
  %0 = bitcast i8* %varargs to i32*
  store i32 1, i32* %0, align 4
  %1 = getelementptr inbounds i8, i8* %varargs, i32 4
  %2 = bitcast i8* %1 to i32*
  store i32 2, i32* %2, align 4
  %3 = getelementptr inbounds i8, i8* %varargs, i32 8
  %4 = bitcast i8* %3 to i32*
  store i32 3, i32* %4, align 4
  %append.srcPtr = bitcast i32* %ints.data to i8*
  %append.new = call { i8*, i32, i32 } @runtime.sliceAppend(i8* %append.srcPtr, i8* nonnull %varargs, i32 %ints.len, i32 %ints.cap, i32 3, i32 4, i8* undef, i8* null)
  %append.newPtr = extractvalue { i8*, i32, i32 } %append.new, 0
  %append.newBuf = bitcast i8* %append.newPtr to i32*
  %append.newLen = extractvalue { i8*, i32, i32 } %append.new, 1
  %append.newCap = extractvalue { i8*, i32, i32 } %append.new, 2
  %5 = insertvalue { i32*, i32, i32 } undef, i32* %append.newBuf, 0
  %6 = insertvalue { i32*, i32, i32 } %5, i32 %append.newLen, 1
  %7 = insertvalue { i32*, i32, i32 } %6, i32 %append.newCap, 2
  ret { i32*, i32, i32 } %7
}

declare noalias nonnull i8* @runtime.alloc(i32, i8*, i8*)

declare { i8*, i32, i32 } @runtime.sliceAppend(i8*, i8*, i32, i32, i32, i32, i8*, i8*)

define internal { i32*, i32, i32 } @main.sliceAppendSlice(i32* %ints.data, i32 %ints.len, i32 %ints.cap, i32* %added.data, i32 %added.len, i32 %added.cap, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %append.srcPtr = bitcast i32* %ints.data to i8*
  %append.srcPtr1 = bitcast i32* %added.data to i8*
  %append.new = call { i8*, i32, i32 } @runtime.sliceAppend(i8* %append.srcPtr, i8* %append.srcPtr1, i32 %ints.len, i32 %ints.cap, i32 %added.len, i32 4, i8* undef, i8* null)
  %append.newPtr = extractvalue { i8*, i32, i32 } %append.new, 0
  %append.newBuf = bitcast i8* %append.newPtr to i32*
  %append.newLen = extractvalue { i8*, i32, i32 } %append.new, 1
  %append.newCap = extractvalue { i8*, i32, i32 } %append.new, 2
  %0 = insertvalue { i32*, i32, i32 } undef, i32* %append.newBuf, 0
  %1 = insertvalue { i32*, i32, i32 } %0, i32 %append.newLen, 1
  %2 = insertvalue { i32*, i32, i32 } %1, i32 %append.newCap, 2
  ret { i32*, i32, i32 } %2
}

define internal i32 @main.sliceCopy(i32* %dst.data, i32 %dst.len, i32 %dst.cap, i32* %src.data, i32 %src.len, i32 %src.cap, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %copy.dstPtr = bitcast i32* %dst.data to i8*
  %copy.srcPtr = bitcast i32* %src.data to i8*
  %copy.n = call i32 @runtime.sliceCopy(i8* %copy.dstPtr, i8* %copy.srcPtr, i32 %dst.len, i32 %src.len, i32 4, i8* undef, i8* null)
  ret i32 %copy.n
}

declare i32 @runtime.sliceCopy(i8*, i8*, i32, i32, i32, i8*, i8*)
