#let numbly(..arr, default: "1.") = (..nums) => {
  let arr = arr.pos()
  nums = nums.pos()
  
  if nums.len() > arr.len() {
    if default == none {
      return none
    }
    if type(default) == function {
      return default(..nums)
    }
    return numbering(default, ..nums)
  }
  
  let format = arr.at(nums.len() - 1)
  if format == none {
    return none
  }
  if type(format) == function {
    return format(..nums)
  }
  
  let segments = format.split(regex("[\{:\}]"))
  let prefix = segments.first()
  let suffix = segments.last()
  let fparts = segments.slice(1, -1).chunks(3)
  
  (
    prefix: prefix,
    numbering: {
      let result = ""
      for part in fparts {
        let level = part.first()
        let fnum = part.at(1)
        let suff = if part.len() > 2 {
          part.last()
        } else {
          none
        }
        
        if fnum == none {
          continue
        }
        
        result += fnum
                
        if suff != none {
          result += suff
        }
      }
      result
    },
    suffix: suffix,
  )
}