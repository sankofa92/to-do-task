\$rails g model User name email password

\$rails g model Task user:references title content:text status priority start_at:date end_at:date

\$rails g model Tag task:references sort
