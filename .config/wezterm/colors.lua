local colors = {}

function colors.grey_alpha(grey, alpha)
   return string.format("rgba(%d%%, %d%%, %d%%, %d%%)", grey, grey, grey, alpha)
end

colors.ansi = {
   --black:   '#1d1f21'
   '#1d1f21',
   --red:     '#cc6666'
   '#cc6666',
   --green:   '#b5bd68'
   '#b5bd68',
   --yellow:  '#f0c674'
   '#f0c674',
   --blue:    '#81a2be'
   '#81a2be',
   --magenta: '#b294bb'
   '#b294bb',
   --cyan:    '#8abeb7'
   '#8abeb7',
   --white:   '#c5c8c6'
   '#c5c8c6',
}
colors.brights = {
   --black:   '#666666'
   '#666666',
   --red:     '#d54e53'
   '#d54e53',
   --green:   '#b9ca4a'
   '#b9ca4a',
   --yellow:  '#e7c547'
   '#e7c547',
   --blue:    '#7aa6da'
   '#7aa6da',
   --magenta: '#c397d8'
   '#c397d8',
   --cyan:    '#70c0b1'
   '#70c0b1',
   --white:   '#eaeaea'
   '#eaeaea',
}
return colors
