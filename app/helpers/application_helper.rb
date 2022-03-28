module ApplicationHelper
  def default_meta_tags
    {
      site: Settings.meta.site,
      reverse: true,
      title: Settings.meta.title,
      description: Settings.meta.description,
      keywords: Settings.meta.keywords,
      canonical: request.original_url,
      og: {
        title: :full_title,
        type: Settings.meta.og.type,
        url: request.original_url,
        image: image_url(Settings.meta.og.image_path),
        site_name: :site,
        description: :description,
        locale: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image'
      },
    }
  end
end
