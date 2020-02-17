from django.conf import settings
from django.db import models
from django.urls import reverse
from django.utils.text import slugify
from django.utils import timezone


class Hobbies(models.Model):
    """Represents a single hobby."""
    name = models.CharField(max_length=100, unique=True,
                            help_text="Name of your hobby.")
    slug = models.CharField(max_length=100, blank=True, editable=False,
                            help_text="Unique URL path to access this page. Generated by the system.")
    content = models.TextField(
        help_text="Write the description of your hobby here.")
    created = models.DateTimeField(auto_now_add=True,
                                   help_text="The date and time this page was created. Automatically generated when the model saves.")
    modified = models.DateTimeField(auto_now=True,
                                    help_text="The date and time this page was updated. Automatically generated when the model updates.")

    def __str__(self):
        return self.name

    def was_published_recently(self):
        # return self.created >= timezone.now() - timedelta(days=1)
        now = timezone.now()
        diff = now - self.created

        if diff.days == 0 and diff.seconds >= 0 and diff.seconds < 60:
            seconds= diff.seconds
            if seconds == 1:
                return str(seconds) +  "second ago"
            else:
                return str(seconds) + " seconds ago"

        if diff.days == 0 and diff.seconds >= 60 and diff.seconds < 3600:
            minutes= math.floor(diff.seconds/60)
            if minutes == 1:
                return str(minutes) + " minute ago"
            else:
                return str(minutes) + " minutes ago"

        if diff.days == 0 and diff.seconds >= 3600 and diff.seconds < 86400:
            hours= math.floor(diff.seconds/3600)
            if hours == 1:
                return str(hours) + " hour ago"
            else:
                return str(hours) + " hours ago"

        # 1 day to 30 days
        if diff.days >= 1 and diff.days < 30:
            days= diff.days
            if days == 1:
                return str(days) + " day ago"
            else:
                return str(days) + " days ago"

        if diff.days >= 30 and diff.days < 365:
            months= math.floor(diff.days/30)
            if months == 1:
                return str(months) + " month ago"
            else:
                return str(months) + " months ago"

        if diff.days >= 365:
            years= math.floor(diff.days/365)
            if years == 1:
                return str(years) + " year ago"

            else:
                return str(years) + " years ago"

    def get_absolute_url(self):
        path_components = {'slug': self.slug}
        return reverse("hobbies-detail", kwargs=path_components)

    def save(self, *args, **kwargs):
        """ Create a URL saafe slug automatically when a new page is created. """
        if not self.pk:
            self.slug = slugify(self.name, allow_unicode=True)

        # Call save on the superclass.
        return super(Hobbies, self).save(*args, **kwargs)

class Attend(models.Model):
    hobby = models.ForeignKey(Hobbies, on_delete=models.CASCADE)
    choice = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)

    def __str__(self):
        return self.choice
