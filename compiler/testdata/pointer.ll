; ModuleID = 'pointer.go'
source_filename = "pointer.go"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-f64:32:64-f80:32-n8:16:32-S128"
target triple = "i686--linux"

define internal void @main.init(i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret void
}

define internal [0 x i32] @main.pointerDerefZero([0 x i32]* %x, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret [0 x i32] zeroinitializer
}

define internal i32* @main.pointerCastFromUnsafe(i8* %x, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %0 = bitcast i8* %x to i32*
  ret i32* %0
}

define internal i8* @main.pointerCastToUnsafe(i32* dereferenceable_or_null(4) %x, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %0 = bitcast i32* %x to i8*
  ret i8* %0
}

define internal i8* @main.pointerCastToUnsafeNoop(i8* dereferenceable_or_null(1) %x, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  ret i8* %x
}

define internal i8* @main.pointerUnsafeGEPFixedOffset(i8* dereferenceable_or_null(1) %ptr, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %0 = getelementptr inbounds i8, i8* %ptr, i32 10
  ret i8* %0
}

define internal i8* @main.pointerUnsafeGEPByteOffset(i8* dereferenceable_or_null(1) %ptr, i32 %offset, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %0 = getelementptr inbounds i8, i8* %ptr, i32 %offset
  ret i8* %0
}

define internal i32* @main.pointerUnsafeGEPIntOffset(i32* dereferenceable_or_null(4) %ptr, i32 %offset, i8* %context, i8* %parentHandle) unnamed_addr {
entry:
  %0 = getelementptr i32, i32* %ptr, i32 %offset
  ret i32* %0
}
