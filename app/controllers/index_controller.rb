class IndexController < ApplicationController
  def index
    @angels = [
      { src: 'angels/P1070452.JPG', alt: 'Angel stained glass' },
      { src: 'angels/P1080099.JPG', alt: 'Angel stained glass' },
      { src: 'angels/P1080584.JPG', alt: 'Angel stained glass' }
    ]

    @lamps = [
      { src: 'lamps/IMG_20170429_175415.jpg', alt: 'Stained glass lamp' },
      { src: 'lamps/IMG_20171015_200059.jpg', alt: 'Stained glass lamp' },
      { src: 'lamps/IMG_20181201_154349.jpg', alt: 'Stained glass lamp' },
      { src: 'lamps/P1050842.JPG', alt: 'Stained glass lamp' }
    ]

    @mandala = [
      { src: 'mandala/IMG_20210228_123517.jpg', alt: 'Stained glass mandala' },
      { src: 'mandala/P1090554.JPG', alt: 'Stained glass mandala' },
      { src: 'mandala/P1100569.JPG', alt: 'Stained glass mandala' }
    ]

    @misc = [
      { src: 'misc/IMG_20200101_183426.jpg', alt: 'Stained glass artwork' },
      { src: 'misc/IMG_20210304_173324.jpg', alt: 'Stained glass artwork' },
      { src: 'misc/P1070673.JPG', alt: 'Stained glass artwork' }
    ]
  end

  def gallery
  end
end
